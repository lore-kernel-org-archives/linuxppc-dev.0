Date: Fri, 26 Jan 2001 00:04:29 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: jekacur@ca.ibm.com
cc: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
Subject: Re:sigcontext on Linux-ppc in user space, another hack.
In-Reply-To: <OF3C25E159.46E6987C-ON852569DF.00700BFE@LocalDomain>
Message-ID: <Pine.GSO.4.10.10101252352100.1508-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 25 Jan 2001 jekacur@ca.ibm.com wrote:

>
> It appears you can just use the siginfo_t * as the struct sigcontext *
> !!!!!!
> ie
> void *signal_handler(int signo, siginfo_t *siginfoptr, struct sigcontext
> *scp)
> {
>      scp = (struct sigcontext_struct *)siginfoptr;
>      /* the rest of your code, here */
> }

Please ignore the last patch!
Anyway, in the code example the last argument is not a sigcontext
structure but an ucontext_t structure, which is defined in <ucontext.h>.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
