Date: Fri, 12 Oct 2001 10:39:35 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: LIDS on PowerPC
Message-Id: <20011012103935.3c104116.jpgarcia@execpc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings.

I was wondering if anyone is willing to help find, or already has an idea on why the Linux Intrusion Detection System (LIDS [www.lids.org]) doesn't allow my ppc system to boot.

Specifically, I have an oldworld system, and using BootX or miBoot with a LIDS kernel (with lids runtime enabled or disabled) results in a hang.  The kernel doesn't even get to the "BootX text" screen.  The LIDS system seems to be an archetecure independent set of modifications, but appears that something was missed in terms of ppc booting (at least on OW systems).

LIDS is a set of kernel modifications that aim to increase system security, especially for server-type systems.  One way I describe it is that it can turn root and daemons/programs from an ultimate power to (on the most paranoid of systems) a normal user or process with limited, selective access.  This way a rooted system and even a trojan can be limited in what they are capable of doing.  Upon supplying a password, this behavior can be disabled for a single terminal.  Network security features are also part of LIDS.

Back in July, I mentioned this on LIDS's own mailing list, but I suppose linuxppc-devel would know more about what conflicts may arise from such kernel modifications.

Thank you all for your time.

--
Joseph P. Garcia
http://www.lycestra.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
