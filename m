Date: Thu, 11 Apr 02 10:15:16 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204111715.AA28956@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

> No, let's fix the brain-damaged serial driver ;)

You mean to support PCMCIA modems in the compiled-in configuration? (It *has*
to be compiled in to support the serial console.) That would be good. Do you
volunteer to fix it in 2.4? 2.5-only is useless.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
