Message-Id: <199902172350.AAA17911@www.luebeck.netsurf.de>
Subject: MKLinux on Performa 6200
Date: Thu, 18 Feb 99 00:49:32 +0100
From: marcos otero garcia <marcos.oterogarcia@luebeck.netsurf.de>
To: <linuxppc-dev@lists.linuxppc.org>, <linuxppc-user@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey,

my name is Marcos I´m mailing from Luebeck-Germany.

I tried to install MK Linux DR3 on a Macintosh Performa 6200. I´ve read in the ReadMe and in the faqomatic of the darmouth university that the Performa 6200 is not supported to run with MKLinux. I´ve asked me if its a problem of the less SCSI HD´s and wrote a mail to covile@apple.com. This Adress I have found in the faqomatic. I gotn´t a reply yet.

So I tried it my way. I connected an Quantum 1GB xternal SCSI HD, made a swap Partition and one filesystem-partition, copied the extensions, controll panles etc. and restarted my older Performa.
The Mac comes up and started Linux

"--- Sorry you need to upgrade your this MKLinux Booter to boot OSF MK Kernel. ---"

I want to run the Performa as a DialIn webserver/like an intranetsever where friends and customers can Dial dircetly in and get information about me. Maybe it will be posibble to access it from the internet using the Network and Backbone of the local ComputerClub "ON" .
I tried to configure it on MacOS but the tools are not very functionally and under System 8.5 not fast except using AppleShare IP or Mac OS X Server. But these tools are to expensive for a student - like me, and without one of these I can´t configure an PPP DialIn (to the Performa) connection.
Many friends got me on Linux. I´ve found MKLinux for Macintosh or PPC based systems.

Now im have spent many time on configurating this server. And I don´t need an AppleTalk Server to print or backup my Data. The only use I have for it to try it for an webserver. I´ve spent many money on a good LinuxBook and bought an xternal SCSICase for the HD because the Performa got no internal SCSI. In the article i´ve read about unsupported IDE-controllers.
and i want to run a Linux System or another good Server on my older Performa. Currently I´m working on a G3 Yosemite.

My Questions:
Does the Installatin not run because of the MK Linux Booter v1.4? What about other Booters
Do I have a chance on running Linux on the Performa 6200?
What about alternative System?

I´ve looked in several mailinglist etc. but nothing found

Here the Screen as it appears when trying to install Linux
---------------------------------------------------------------------------------------------------------------------------------------

Mach3.0  VERSION(PMK1.1): gilbert <osfmk> Wed Jun 10 17:45:07 PDT 1998; mach_kernel/PRODUKTION (venus.apple.com)

Sorry! You need to upgrade your MKLinux Booter to boot this OSF MK kernel.
(it can be found in your MacOS Systemfolder: Extensions Folder)
Mach Microkernel is booting on a Power Macintosh Performa (unsupported) class machine
mem_size = 64M
vm_page_bootstrap: 15328 free Pages
panic: Unsupported class for Interrupt dispatcher

No debugger configured - dumping debug information

version string : Mach3.0  VERSION(PMK1.1): gilbert <osfmk> Wed Jun 10 17:45:07 PDT 1998; mach_kernel/PRODUKTION (venus.apple.com)

backtrace: 0025f31c 00212454 00268874 0026b0e8 0025efc4 00226e04 0025ecec 0025e3d4

please report the above messages to
bugs@mklinux.apple.com and reboot your machine

-------------------------------------------------------------------------------------------------------------------------------------------
Technical Spec of "my"Performa 6200

PowerPC 603 CPU with 75MHZ
64 MD SIMM RAM
running under System 8.5
using an 4GB internal IDE Seagate with MacOs System HFS-Standard (HDT Driver)
and an xternal 1GB Quantum 1080 S Empire for Linux (700 for filesystem, 64 MB for swap) and MacOS (250MB partition for System and other LINUXinstaller files)

an Asante Maccon 10BaseT CommSlotI EthernetAdapter

for more information - I think you have a datasheet about all Mac Modells. If not mail me
------------------------------------------------------------------------------------------------------------------------------------------

Please help me. Now I´m over two days reading books preparing the Hardware, surfing the web for Info.
I´´ve Spent 350DM (will be about 150 EUR) on HardWare and Books. My girlfriend says that I´m getting silly.
There must be a way to use this performa as a good Server with Linux.
Hardware with the same manufacturing date is supported too and Linux runs on cheap PC System´s for less then 1000 DM (maybe 500 EUR).



If there is no way to run Linux on the Performa 6200 tell me what to do with the machine!


Please excuse my bad english. I hope I get an answer. 

Thanks for interest and help...

now I´m exhausted - I will go to bed


cu


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
