Message-ID: <38E90159.DB89C967@machinasapiens.com>
Date: Mon, 03 Apr 2000 16:38:49 -0400
From: Pierre Sarrazin <sarrazip@machinasapiens.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: R_PPC_REL24 relocation out of range, with trivial program
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Last month I posted the following message:

From: Pierre Sarrazin
Date: Thu, 02 Mar 2000 18:25:46 -0500
> This is another message about the "R_PPC_REL24 relocation out of range"
> problem. I have a trivial program and library system that illustrates it.
> I have read some of the previous messages on this topic but the solutions
> proposed did not make a difference.
>
> The problem happens when the dlopened library exports a C++
> function returning 'string', but not when it exports a function
> returning 'const char *'.
>
> Here is the program:
	[...]


The full message is at:
http://lists.linuxppc.org/listarcs/linuxppc-dev/200003/msg00025.html


I would like to know if there is a chance that this problem will
be fixed soon. I have had to suspend my LinuxPPC work for the
last month. My company's support for the LinuxPPC platform is
delayed by this issue.

Is there a way to ask gcc to generate only long branch instructions
so as to avoid this whole problem? Thanks.

--
Pierre Sarrazin <sarrazip@machinasapiens.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
