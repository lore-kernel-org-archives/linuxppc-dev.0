MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16604.50307.901331.251674@cargo.ozlabs.ibm.com>
Date: Sat, 26 Jun 2004 10:34:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Yuri Frolov <yfrolov@dev.rtsoft.ru>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Unsuccessfull system call interception. Please, help to correct it
 or make a suggestion.
In-Reply-To: <40DC1669.5060808@dev.rtsoft.ru>
References: <40DC1669.5060808@dev.rtsoft.ru>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yuri Frolov writes:

> The problem: due to the necessity of logging system calls entry/exit
> events by LTT the arch/ppc/kernel/entry.S was modified in this way:

First, you don't say whether you are working on 2.4 or 2.6.

Secondly, why can't you use the existing syscall trace infrastructure?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
