Date: Mon, 7 Jun 1999 22:53:53 +0200 (MET DST)
From: Herve Choplin <choplin@delphi.phys.univ-tours.fr>
To: linuxppc-dev@lists.linuxppc.org
cc: linuxppc-users@lists.linuxppc.org
Subject: RS6000 43P-140 (7043)
Message-ID: <Pine.OSF.4.02A.9906072243410.2574-100000@delphi.phys.univ-tours.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a RS6000 43P-140, that is a PReP machine (it seems) with the
TIGER1 motherboard.
A prep-installer does exist for this ?
Below is the configuration (hdisk0 contain AIX, hdisk2 is empty and
not partitioned) :

INSTALLED RESOURCE LIST WITH VPD

The following resources are installed on your machine.
	
  Model Architecture: rspc
  Model Implementation: Uni-Processor, PCI bus

  sysplanar0        00-00             System Planar
  bus0              00-00             PCI Bus
  bus1              04-A0             ISA Bus
  siota0            01-A0             Tablet Adapter
  ppa0              01-B0             Standard I/O Parallel Port Adapter
  sa0               01-C0             Standard I/O Serial Port 1
  sa1               01-D0             Standard I/O Serial Port 2
  paud0             01-E0             Ultimedia Integrated Audio
  sioka0            01-F0             Keyboard Adapter
  kbd0              01-F0-00-00       PS/2 keyboard
  sioma0            01-G0             Mouse Adapter
  mouse0            01-G0-00-00       3 button mouse
  fda0              01-H0             Standard I/O Diskette Adapter
  fd0               01-H0-00-00       Diskette Drive
  pmc0              01-I0             Power Management Controller
  ent0              04-B0             IBM PCI Ethernet Adapter (22100020)

        Network Address.............0006292E9FD4
        Displayable Message.........PCI Ethernet Adapter (22100020)

  scsi0             04-C0             Wide SCSI I/O Controller
  hdisk0            04-C0-00-1,0      Bull 2.0 GB 16 Bit SCSI Disk Drive

        Manufacturer................SEAGATE 
        Machine Type and Model......ST32151W        
        ROS Level and ID............0526
        Serial Number...............00J30002

  cd0               04-C0-00-3,0      SCSI Multimedia CD-ROM Drive (650
                                      MB)

        Manufacturer................IBM     
        Machine Type and Model......CDRM00203
        ROS Level and ID............1.01
        Device Specific.(Z0)........058002028F000018
        Part Number.................93H8050     
        EC Level....................E77587    
        FRU Number..................93H8055     

  hdisk2            04-C0-00-4,0      16 Bit SCSI Disk Drive (2160 MB)

        Manufacturer................IBM     
        Machine Type and Model......DCAS-32160W   !#
        FRU Number..................07H1119     
        ROS Level and ID............53363944
        Serial Number...............B2G55374
        EC Level....................E60232    
        Part Number.................73H7675 
        Device Specific.(Z0)........000002028F00003A
        Device Specific.(Z1)........73H8012     
        Device Specific.(Z2)........0933
        Device Specific.(Z3)........0398 
        Device Specific.(Z4)........
        Device Specific.(Z5)........

  rmt0              04-C0-00-5,0      Bull 7/14 GB 8mm Tape Drive

        Manufacturer................EXABYTE 
        Machine Type and Model......EXB-8505        
        ROS Level and ID............07T0
        Device Specific.(EE)........    
        Serial Number...............06322385  
        Device Specific.(Z0)........0180020265000010

  bus2              04-D0             PCI Bus
  mga0              04-01             GXT120P Graphics Adapter

      GXT120P 2D Graphics Adapter:
        EC Level....................E76026B
        FRU Number..................93H2534
        Manufacture ID..............MATROX
        Part Number.................93H9474
        Serial Number...............H0101006
        Version.....................RS6K

  mem0              00-00             Memory
  proc0             00-00             Processor
  L2cache0          00-00             L2 Cache

I have heard that a developement is previous; how can I have news on it?

Thank's

Hervé CHOPLIN         UNIVERSITÉ FRANÇOIS RABELAIS - TOURS FRANCE
Tél.: (33) 02.47.36.69.38 - Fax: (33) 02.47.36.70.40
E-mail: choplin@delphi.phys.univ-tours.fr - Herve.Choplin@wanadoo.fr      
URL:    http://delphi.phys.univ-tours.fr/HC/Choplin_fr.html



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
