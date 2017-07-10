from libcpp.string cimport string
from libcpp.vector cimport vector as std_vector
from libcpp.map cimport map as std_map


cdef extern from "maya/MObject.h" namespace "MEDIC":
    cdef cppclass MObject


cdef extern from "medic/node.h" namespace "MEDIC":
    cdef cppclass MdNodeIterator:
        MdNodeIterator()
        MdNodeIterator(MdNodeContainer *container)
        MdNode *next()
        bint isDone()

    cdef cppclass MdNodeContainer:
        MdNodeIterator iterator()

    cdef cppclass MdNode:
        MdNode(string name)
        string name() const
        string type() const
        bint isDag() const
        void parents(MdNodeContainer *container) const
        void children(MdNodeContainer *container) const


cdef extern from "medic/report.h" namespace "MEDIC":
    cdef cppclass MdReport:
        MdNode *node()
        MObject &components()
        bint hasComponents()

    cdef cppclass MdReportIterator:
        MdReportIterator()
        MdReport *next()
        bint isDone()

cdef extern from "medic/tester.h" namespace "MEDIC":
    cdef cppclass MdTesterIterator
    cdef cppclass MdTester:
        string Name() const
        string Description() const


cdef extern from "medic/karte.h" namespace "MEDIC":
    cdef cppclass MdKarte:
        string Name() const
        string Description() const


cdef extern from "medic/visitor.h" namespace "MEDIC":
    cdef cppclass MdVisitor:
        MdVisitor()
        void visit(MdKarte *k)
        std_vector[MdTester *] reportTesters()
        MdReportIterator report(MdTester *tester)


cdef extern from "medic/pluginManager.h" namespace "MEDIC":
    cdef enum MdPluginLoadingStatus:
        MdLoadingFailure = 0
        MdLoadingSuccess
        MdExistsPlugin

    cdef cppclass MdPlugInManager:
        @staticmethod
        MdPlugInManager *Instance()
        std_vector[string] testerNames()
        std_vector[string] karteNames()
        MdTester *tester(string name)
        MdKarte *karte(string name)
        MdPluginLoadingStatus addTester(string pluginPath)
        MdPluginLoadingStatus addKarte(string name, string description, std_vector[string] testerNames)
        
