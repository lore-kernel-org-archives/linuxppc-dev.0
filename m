Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87162B70A0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 01:41:53 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6GFerak012416
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 11:40:53 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6GFfo3V157642
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 11:41:50 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6GFfolp013255
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 12:41:50 -0300
Message-ID: <4C407DBC.3060007@austin.ibm.com>
Date: Fri, 16 Jul 2010 10:41:48 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/7] De-couple sysfs memory directories from
	memory	sections
References: <4C3B3446.5090302@austin.ibm.com>
	<20100716071320.GC31612@kroah.com>
In-Reply-To: <20100716071320.GC31612@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/16/2010 02:13 AM, Greg KH wrote:
> On Mon, Jul 12, 2010 at 10:27:02AM -0500, Nathan Fontenot wrote:
>> This set of patches de-couples the idea that there is a single
>> directory in sysfs for each memory section.
> 
> Any reason you didn't cc: the sysfs maintainer on these patches?  If
> not, I'll gladly ignore them...

Ummm.... I have no good excuse. :)

Will add you to cc for v3 of the patch.

> 
> (hint, scripts/get_maintainer.pl is your friend...)
Thanks.

-Nathan
> 
> greg k-h
