Message-ID: <F14441D40E5AD3118886005004607AD10BDD30@mail.libra.de>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Status of hfs support as of 2.4.0-test1-ac21
Date: Fri, 23 Jun 2000 11:57:55 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I played around with hfs support in this developer kernel and
penetrated my hfs partion with some paralell cp-s and rm-s
(I copied "the linux kernel" documentation around :-)
After every step I rebootet into MacOs and ran DiskFirstAid (DFA)
but nothing was found. cp and rm complained about problems with the
.finderinfo and .resource directories, but I expected it this way.
I used my iBook for testing.

Is there anything else i _must_ check for a fs to be considered
stable ?

In case anyone reports a bug to me in this area I'll try to fix
it.

Meanwhile I'll have a look at the hfsutils
( http://www.mars.org/home/rob/proj/hfs/ ) and will start
moving them to HFS+.

I found however some bugs not related to hfs and may reproduce
them in detail in case someone asks:
  - the console driver messed up some pixels while editing
  - hdparm did not always work correctly
    (I use pmud and it calls hdparm depending on the battery load)
    Sometimes I got stuck with the message "hda interrupt lost"
    or similar.


Greetings,

|       |                   Klaus Halfmann    khalfmann@libra.de
|       |
|    i  | --.  r---  --- |  Libra Software    Tel +49 (0)621 41997-0
|    |  b-- |  |    a--- |  Erzbergerstr. 17  Fax +49 (0)621 41997-30
L--- |  --- |  |    .----.  68165 Mannheim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
