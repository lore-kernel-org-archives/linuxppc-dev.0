Message-ID: <379E3513.738D0449@msoe.edu>
Date: Tue, 27 Jul 1999 17:39:15 -0500
From: ian geiser <geiseri@msoe.edu>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        LinuxPPC List <linuxppc-user@lists.linuxppc.org>
Subject: G3 Upgrade Questions....
Content-Type: multipart/mixed;
 boundary="------------5A0AED7530F4A5774DDE5248"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5A0AED7530F4A5774DDE5248
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,
    I just installed a G3 upgrade card into my powercenter132
    It is a 400Mhz with 1Meg at 200Mhz....
    It registers under MacOS perfectly but i get the following under
    proc/cpuinfo:
    processor       : 0
    cpu             : 750
    temperature     : 0 C            <--Is this correct?!
    clock           : 195MHz        <-- Is this correct?!
    revision        : 130.1
    bogomips        : 399.77
    zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/1084 (0%)
    machine         : Power Macintosh
    motherboard     : AAPL,7300 MacRISC
    memory          : 112MB

    it only registers 195 Mhz and 0C for the temp... is the correct?
    i am running Kernel 2.2.10

    -ian reinhart geiser

--
.-----------------------------------------------------------.
|[]                   NeXT Generation                    [X]|
|--------------------------,--------------------------------.
|  PC Network Specialist,  | Office:    CCSD Data Center    |
|  Macintosh Specialist @  | Phone:     414.277.4528        |
|  Milwaukee School of     |                                |
|        Engineering       |--------------------------------|
|                          |                                |
|   ian reinhart geiser    | phone:   414.220.9683          |
|   Apt #510A              | email:   geiseri@msoe.edu      |
|   1029 N Jackson St      | web:     www.msoe.edu/~geiseri |
|   Milwaukee, WI 53202    |  NeXT/Be/Cyberdog Mail okay!   |
|                          |   MIME or BinHex prefered      |
|--------------------------'--------------------------------|
'-----------------------------------------------------------'



--------------5A0AED7530F4A5774DDE5248
Content-Type: text/x-vcard; charset=us-ascii;
 name="geiseri.vcf"
Content-Description: Card for ian geiser
Content-Disposition: attachment;
 filename="geiseri.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard 
n:geiser;ian
tel;pager:414-402-8302
tel;cell:414-688-0535
tel;home:414-220-9683
tel;work:414-277-7143
x-mozilla-html:TRUE
url:http://www.msoe.edu/~geiseri
org:Geek Central
version:2.1
email;internet:geiseri@msoe.edu
title:Geek
adr;quoted-printable:;;Apt 5=0D=0A828 N Milwaukee St;Milwaukee;Wisconsin;53202;USA
x-mozilla-cpt:;0
fn:ian reinhart geiser
end:vcard

--------------5A0AED7530F4A5774DDE5248--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
