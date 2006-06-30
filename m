Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [powerpc] cleanup of_device_(un)register
Date: Fri, 30 Jun 2006 16:30:14 +1000
References: <1151636581.762717.409507295266.qpush@pokey>
In-Reply-To: <1151636581.762717.409507295266.qpush@pokey>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606301630.16260.jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> of_device_register() and of_device_unregister() modify the contents
> of property values, so use of_find_property rather than get_property.

OK, looks like nothing else in the kernel uses the linux,device 
property, and seeing as it's a kernel pointer, it's kinda useless to 
userspace.

Anyone mind if I remove the linux,device property completely?


Jeremy
