Subject: Linux 2.6 and MVME5100
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1085837483.3434.31.camel@lancelot.dubois.etowns.net>
Mime-Version: 1.0
Date: Sat, 29 May 2004 15:31:23 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I recently downloaded Linux 2.6.6 from kernel.org and found that the
support for the MVME5100 was added to the 2.6 kernel.

Unfortunately it seems that the mvme5100 related files are out of sync
with the 2.6 tree (the compilation fails with prototype errors, unknown
header files ...). Actually it seems that no or little porting has been
done since Monta-Vista contributed them from their Linux 2.4 kernel.

I am in the process of fixing things so that I can compile 2.6 for the
VME board but before going too far, I'd like to know if this is a known
problem, if others already compiled 2.6 successfully for the MVME5100
(If so please a brief explanation would be appreciated) and if there is
a person responsible for consolidating all changes related to the
MVME5100.

Thanks for your time

JC

--
Jean-Christophe Dubois <jcd@tribudubois.net>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
