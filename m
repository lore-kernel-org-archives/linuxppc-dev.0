Message-ID: <3ECDF370.7020808@elsoft.ch>
Date: Fri, 23 May 2003 12:09:52 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ERR51 / ERR77 on IBM405GPr
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

According to the errata sheet, the IBM405GPr doesn't suffer from the
ERR51 / CPU_190 and ERR77 / CPU_210 bugs as the IBM405GP does.

But the workarounds are still enabled in "arch/ppc/config.in".

Shouldn't there be something like this:

  if [ "$CONFIG_405GPR" = "y" ]; then
    define_bool CONFIG_IBM405_ERR51 n
    define_bool CONFIG_IBM405_ERR77 n
  fi


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
