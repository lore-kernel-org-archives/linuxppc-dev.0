Date: 31 Aug 2000 17:41:14 -0500 
Subject: Re: asm in OF? YES!
From: "Bruce Anderson" <brucea@spacestar.net>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <B5D4493E-53821@192.168.2.21>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 31, 2000 2:52 AM, Gabriel Paubert <mailto:paubert@iram.es>
wrote:
>
>You've just got to love OF portability across machines and architecture
>independance :-( Add to this the fact that I have somewhere a FirmWorks
>document which claims that on PPC the top of the stack is always in r28,
>r20/r21 are scratch registers. r31 is still the stack pointer (and r30 the
>return stack AFAIR).
>
>

Your asumption about OF portability is in error. Apple does not
use FirmWorks OF code.  Apple created their own "OF" version that
resembles FirmWorks OF vocabulary.



" Stamp out root logins .  .  .  . su "   --Bruce Anderson
 This message was created and sent using Cyberdog 2.0, MacOS 8.6,
 awk, find, sed, sendmail, sh, and NetBSD a free Multi-Platform OS.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
