Return-Path: <michel@tungstengraphics.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id C3C8ADDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 23:09:51 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so1354552eyi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 05:09:48 -0700 (PDT)
Subject: Re: [PATCH] uninorth agp: don't mark module parameter __devinit
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1225246284.1369.31.camel@johannes.berg>
References: <1225246284.1369.31.camel@johannes.berg>
Content-Type: text/plain; charset=utf-8
Date: Wed, 29 Oct 2008 13:09:45 +0100
Message-Id: <1225282185.3546.376.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-29 at 03:11 +0100, Johannes Berg wrote:
> A module parameter can possibly be shown via sysfs, which isn't a good
> idea if the section has been removed, so remove the __devinit
> annotation.

Under what circumstances could it be shown in sysfs?


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
