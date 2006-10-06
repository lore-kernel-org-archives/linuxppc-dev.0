Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] linux,tce-size property is 32 bits
Date: Fri, 6 Oct 2006 12:16:30 +1000
References: <20061005032800.GH24705@localdomain>
	<1160039899.22232.54.camel@localhost.localdomain>
	<20061005143244.GJ24705@localdomain>
In-Reply-To: <20061005143244.GJ24705@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610061216.32315.jk@ozlabs.org>
Cc: Nathan Lynch <ntl@pobox.com>, matthltc@us.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> AFAICT this was introduced by the "Constify & voidify get_property()"
> series which went in post-2.6.18 so no backport for -stable is
> needed.  Not sure about RHEL5.

That patch (954a46e2d5aec6f59976ddeb1d232b486e59b54a) did touch the 
declaration of sizep, but only changed it from an unsigned long * to an 
const unsigned long *.

Looking at the git log, it's been an unsigned long from the beginning 
(ie, being moved from arch/ppc64). You may need to check the stable and 
RHEL trees explicitly.

Regards,


Jeremy
