Date: Thu, 9 Dec 1999 13:22:30 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: Ilya Gindentuller <igin@vrcomm.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What are the best cross-development tools to build Linux for
 MPC860, kernel ver. 2.2.13 or later?
In-Reply-To: <000901bf4277$a7c043c0$65daa8c0@vrcomm.com>
Message-ID: <Pine.SGI.4.10.9912091318140.158374-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ilya:

I'd strongly recommend taking one or more of your Windows 98/NT machines
and installing Linux on them. You can then easily build and install a GCC
cross-compiler there and do your development in that environment. This
will serve two purposes A) acclimate you with Linux and B) make your
development work easier than if you were to do it from Windows.

If that's out-of-the-question, I believe it is, in theory, possible to
compile GCC for DOS and Cygnus (now Red Hat) may even sell a precompiled,
supported package for this environment.

Regards,

Grant

On Thu, 9 Dec 1999, Ilya Gindentuller wrote:
> We are complete novices in Linux development and want to learn how to
> use Linux on MPC860. So, please help us out since we are stuck with so
> many choices and versions floating around.
> 
> I found Linux port for MPC860 ver.2.2.13 (in the ftp section of
> www.ppc.kernel.org) and I want to build it (as is) to run on our EST
> board.
> 
> We have to do cross-development under Windows 98/NT. I searched
> mailing lists and it looks that everybody is using native Linux (MAC)
> machines to do development - no cross-development environment.
> 
> Please, could somebody direct us to the best source of embedded Linux
> cross-development tools that we can use on Windows 98/NT x86 machine
> to generate code for MPC860 EST board?
> 
> All input and instructions are welcome and greatly appreciated.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
