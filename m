Subject: Re: FYI: Free Online Book: Inside Linux Kernel and PowerPC
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: huailin@xtrj.org
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040122185859.54320.qmail@web21410.mail.yahoo.com>
References: <20040122185859.54320.qmail@web21410.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1075211940.8619.20.camel@spawn.uab.ericsson.se>
Mime-Version: 1.0
Date: Tue, 27 Jan 2004 14:59:01 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-01-22 at 19:58, Huailin Chen wrote:
> Chapter 3: PowerPC EABI
> Chapter 15: PowerPC EABI Cross Compiler

Well we actually use system V ABI for linux binaries and making a cross
compiler with TARGET=powerpc-linux can also use EABI with the -meabi
option.

Perhaps pointing to dan kegel's crosstool would be better than invent
your own way.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
