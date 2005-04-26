Return-Path: <jjboor@aimsys.nl>
Received: from smtp04.wanadoo.nl (smtp04.wanadoo.nl [194.134.35.144])
	by ozlabs.org (Postfix) with ESMTP id E1C5767AC7
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 23:48:18 +1000 (EST)
In-Reply-To: <BPEMKMADCCCPHPEDDKOOCEDLCEAA.surendra.yadav@softdel.com>
References: <BPEMKMADCCCPHPEDDKOOCEDLCEAA.surendra.yadav@softdel.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6fbd8d55bd87c2dd15c4da03da915ef5@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Tue, 26 Apr 2005 15:31:25 +0200
To: surendra.yadav@softdel.com
Cc: linuxppc-dev@ozlabs.org
Subject: Re: gdbserver problem on powerpc.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi surendra,

You might miss one or all libraries on your target? what is:

ldd gdbserver

saying when you try this on your target?

Jaap-Jan

On 26-apr-05, at 15:05, Surendra Yadav wrote:

> Hi,
>
> I downloaded gdb-6.0 and cross compiled gdbserver for powerpc platform.
>
> When gdbserver I tried to run gdbserver it gives "No such file or
> directory".
> But I can see this file is present in the bin directory. Even I tried
> precompiled binary from ELDK but that also does not work and gives the 
> same
> message. Can any one suggest what is the wrong?
>
> I gave the command #gdbserver 192.168.10.243:2345 hello .
>
> Alternatively I tried following command from the bin directory. hello
> program is also in the bin the dir. But it won't work.
>
> #./gdbserver 192.168.10.243:2345 ./hello
>
> Regards,
> Surendra
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
