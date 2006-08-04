Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 379D167B22
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 19:56:54 +1000 (EST)
Message-ID: <44D319E0.9080502@sipsolutions.net>
Date: Fri, 04 Aug 2006 11:56:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
MIME-Version: 1.0
To: Francois Barre <francois.barre@gmail.com>
Subject: Re: AOA and Toonie (Mac Mini) : nothing happens
References: <fd8d0180608040253h11ebf168p8656b370857f1647@mail.gmail.com>
In-Reply-To: <fd8d0180608040253h11ebf168p8656b370857f1647@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The mac mini isn't quite supported yet, the relevant patches are in the 
alsa mercurial repo.

However, it should auto-load snd-aoa-fabric-layout (and then crash). Can 
you privately send me a tarball of /proc/device-tree?

johannes
