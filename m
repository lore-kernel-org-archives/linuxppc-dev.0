From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15304.7969.163728.922055@cargo.ozlabs.ibm.com>
Date: Sat, 13 Oct 2001 21:01:53 +1000 (EST)
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LIDS on PowerPC
In-Reply-To: <20011012103935.3c104116.jpgarcia@execpc.com>
References: <20011012103935.3c104116.jpgarcia@execpc.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph P. Garcia writes:

> Specifically, I have an oldworld system, and using BootX or miBoot
> with a LIDS kernel (with lids runtime enabled or disabled) results
> in a hang.  The kernel doesn't even get to the "BootX text" screen.

Hmmm, I would be surprised if LIDS was affecting anything that early
on in the boot process.  Have you successfully built and booted a
kernel without LIDS?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
