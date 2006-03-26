Return-Path: <hans@fugal.net>
Received: from mgr3.xmission.com (mgr3.xmission.com [198.60.22.203])
	by ozlabs.org (Postfix) with ESMTP id 07AB867A5A
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2006 08:44:16 +1100 (EST)
Message-ID: <44270B34.3070406@fugal.net>
Date: Sun, 26 Mar 2006 14:44:20 -0700
From: Hans Fugal <hans@fugal.net>
MIME-Version: 1.0
To: Hollis Blanchard <hollis@penguinppc.org>
References: <442008EE.6040808@fugal.net>
	<ce3dc94b4e52e43d812f3783b6fc8b42@penguinppc.org>
In-Reply-To: <ce3dc94b4e52e43d812f3783b6fc8b42@penguinppc.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: make install on ppc
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
> On Mar 21, 2006, at 8:08 AM, Hans Fugal wrote:
> 
>> Is there something that stops us from having a make install target for 
>> ppc?
> 
> Why do you want it, and what would it do? Clearly not many people have 
> needed it so far...

I bet a lot of people have typed it, wished it was there, then worked 
around it. That's what I've been doing for a year now.

It doesn't do much - basically it has the proper dependencies and runs 
installkernel with the appropriate arguments (as indicated by `make help`).

Thanks
