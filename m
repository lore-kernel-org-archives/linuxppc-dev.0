Date: Fri, 23 Aug 2002 10:32:40 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: shaowei dai <dshaowei@rfnetech.com>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA on an MPC860
Message-ID: <20020823103240.J12271@zambia.cambridgebroadband.com>
References: <3D64DA41.3000104@cambridgebroadband.com> <3D65EDC0.E16387CD@imc-berlin.de> <20020823095133.F12271@zambia.cambridgebroadband.com> <007701c24a86$52d72620$bfba459b@ntu.edu.sg>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: <007701c24a86$52d72620$bfba459b@ntu.edu.sg>; from dshaowei@rfnetech.com on Fri, Aug 23, 2002 at 10:20:29 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 2002.08.23 10:20 shaowei dai wrote:
>
> Hi, Alex:
>
> You might want to use 'ksymoops' to find more useful information from
> this
> oops.
> It's smart to tell you which routine caused the trouble.


Ah, I didn't actually know about ksymoops!!!  Here is the decoded Oops:

>> NIP; c00c0a0c <create_proc_ide_interfaces+208/3670>   <=====
Trace; c00c0a00 <create_proc_ide_interfaces+1fc/3670>
Trace; c00c0f04 <create_proc_ide_interfaces+700/3670>
Trace; c00c10ec <create_proc_ide_interfaces+8e8/3670>
Trace; c00c188c <create_proc_ide_interfaces+1088/3670>
Trace; c00c221c <create_proc_ide_interfaces+1a18/3670>
Trace; c00bbfd4 <ide_revalidate_disk+228/450>
Trace; c00bcaac <ide_register_hw+140/18c>
Trace; c00bcb4c <ide_register+54/68>
Trace; c403f7a4 <[ide_cs]ide_config+5c8/774>
Trace; c403fbe0 <[ide_cs]ide_event+9c/110>
Trace; c40031bc <[pcmcia_core]register_client+2ac/2e8>
Trace; c4004808 <[pcmcia_core]CardServices+104/1e4>
Trace; c403f18c <[ide_cs]__module_parm_irq_list+108/158>
Trace; c400f874 <[ds]bind_request+1b0/1fc>
Trace; c40105b4 <[ds]ds_ioctl+584/714>


Alex

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
