Message-ID: <38FDBB60.34DE949@sympatico.ca>
Date: Wed, 19 Apr 2000 09:57:52 -0400
From: Stephane Laroche <stephane.laroche@sympatico.ca>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: char type is unsigned with PPC gcc?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just finished debugging the ASH shell, which wasn't running properly
on my 860, and found out that it assumes (correctly if you ask me) that
the type 'char' is signed.

GCC 2.95.2 is configured to have chars unsigned by default on the
PowerPC platforms.  The x86 GCC configures char to be signed... (looking
at gcc/config/rs6000/rs6000.h for the ppc)

Anyone knows why the PowerPC is different in this regard?

Surely I'm not the first one to come across this problem.  Should I fix
ASH or should I reconfigured gcc to default to signed char?  I think the
latter is a better idea since, if I remember correctly, ANSI C says that
char should be signed.

-Stephane


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
