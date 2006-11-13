Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id E586367D74
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 15:45:57 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAD4jusa026675
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:45:56 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAD4judI026663
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 13:45:56 +0900 (JST)
Message-ID: <4557F87D.6040908@am.sony.com>
Date: Sun, 12 Nov 2006 20:45:49 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 14/16] powerpc: add ps3 platform OS params support
References: <4554DB20.9020200@am.sony.com>	
	<1163381393.7410.39.camel@localhost.localdomain>	
	<4557E45C.10703@am.sony.com>
	<1163390536.7410.61.camel@localhost.localdomain>
In-Reply-To: <1163390536.7410.61.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
>> It is not so convenient to view, but the other os area is documented in the
>> iso image CELL-Linux-CL_20061110-ADDON.iso at
>> http://ftp.uk.linux.org/pub/linux/Sony-PS3/.
> 
> Any chance we can get that in some sort of non-insane format? Like a
> PDF? :)

OK, I put it here for you:

 http://67.117.136.164/pub/cell/linux-20061110-docs/BootLinuxAndInstallation.html

The coverage of the other os area is not so good, but more complete
documentation should be provided sometime in the future.


>> >> +	if (header->hdr_version != 1) {
>> >> +		pr_debug("%s:%d hdr_version failed\n", __func__, __LINE__);
>> >> +		return -1;
>> >> +	}
>> > 
>> > Is version 2 not going to be backward compatible? Could it be >= 1 ?
>> 
>> 
>> I have absolutely no clue what the next version number will be, nor the
>> compatibility, etc.  I'll set this when the version changes.
> 
> Except you'll have trouble changing it on the installed base of millions
> of PS3s running Linux :) - At the moment if firmware bump the version on
> you, you've got an unbootable system until the user does a kernel
> upgrade. But it's your baby.

Good point.  Actually, you'll just have a little inaccuracy in your clock
for this version, but I'll change it.


-Geoff
