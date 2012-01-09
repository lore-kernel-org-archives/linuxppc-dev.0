Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B0F25B6F70
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 01:20:27 +1100 (EST)
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE01D34F@HYD-MKD-MBX4.wipro.com>
References: <20111230182806.21CF61931810@gemini.denx.de>
 <40631E9A2581F14BA60888C87A76A1FE01D34F@HYD-MKD-MBX4.wipro.com>
Subject: Re: Mac address in the DT
To: <smitha.vanga@wipro.com>
Message-ID: <OF5FE90C20.B5971F88-ONC1257980.004EAA90-C1257980.004EC4DA@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 9 Jan 2012 15:20:22 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Hi Wolfgang,
>
> I need to automate a sequence of commands. To do that I am setting a environment variable with the sequence of commands.
> And using run command run the environment variable.
>
> But one of the command uses " in the command. So how do I save the command with quotes.
>
> Below is the command which I want to set in the environment variable.
>
> setenv set_mac ""cp 0xffec0000 0x100000 1024;fdt addr 0x100000 8192;fdt set /soc8272@f0000000/ethernet@24000 mac-address "[00 22 00 33 00 55]""
>
> But when I saveenv the command doesnot get save as fdt set /soc8272@f0000000/ethernet@24000 mac-address "[00 22 00 33 00 55]"
>
> Thanks & Regards,
> Smitha

Have you tried ...\"[00 22 00 33 00 55]\"" ?

 Jocke
