Date: Sat, 19 Jul 2003 11:37:22 +0000
From: Giuliano Pochini <pochini@shiny.it>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 mdd help request [solved]
Message-Id: <20030719113722.1dab30c0.pochini@shiny.it>
In-Reply-To: <XFMail.20030717124840.pochini@shiny.it>
References: <20030717073956.GH7926@plato.local.lan>
	<XFMail.20030717124840.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It wasn't my fault. There is a bad interaction between the G4-MDD and the
Adaptec [23]9160 family. I quote here the relevant part from ask.adaptec.com
because it may be useful to someone else:


----
System will not boot to a drive attached to an Adaptec SCSI card on
QuickSilver G4s.

This information applies to the following product(s):

PowerDomain 29160, 29160N, 39160 PCI SCSI Card


To work around this issue print out the instructions that are below and
follow them exactly:

1) Reboot, holding down command-option-O-F all at the same time at startup.
This will bring up a white screen starting with "Open Firmware" and ending
with a "0 >" prompt.

2 When the Open Firmware prompt appears, type the following: (Note that the
spaces between quotes are important and the instructions are case sensitive)

setenv fcode-debug? true

3) At the "0 >" prompt type the following and then press the return key

printenv

4) Verify the following line exists in the output, generally 4 to 6 lines down

fcode-debug? true false

5) At the "0 >" prompt type the following and then press the return key

mac-boot

6) Once the system is up, select appropriate drive (using Startup Disk in
the Control Panels folder under Mac OS 9 or in Startup Disk in System
Preferences under Mac OS X) and reboot.
----



--
Bye.
   Giuliano.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
