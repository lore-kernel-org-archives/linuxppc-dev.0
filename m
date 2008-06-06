Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 352EEDDEE7
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 09:23:03 +1000 (EST)
Date: Fri, 6 Jun 2008 18:06:38 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] make walk_memory_resource available with
	MEMORY_HOTPLUG=n
Message-ID: <20080606230638.GC6638@localdomain>
References: <200805071443.20192.hannes.hering@linux.vnet.ibm.com>
	<20080528164405.GA4836@localdomain>
	<200806031007.40162.hannes.hering@linux.vnet.ibm.com>
	<20080603204908.GB7475@localdomain>
	<1212527335.23656.2.camel@badari-desktop>
	<4845B382.20205@garzik.org> <20080603223054.GC7475@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080603223054.GC7475@localdomain>
Cc: tklein@de.ibm.com, Jeff Garzik <jeff@garzik.org>, themann@de.ibm.com,
	Hannes Hering <hannes.hering@linux.vnet.ibm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Badari Pulavarty <pbadari@us.ibm.com>,
	ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> The ehea driver was recently changed[1] to use walk_memory_resource() to
> detect the system's memory layout.  However, walk_memory_resource() is
> available only when memory hotplug is enabled.  So CONFIG_EHEA was
> made to depend on MEMORY_HOTPLUG [2], but it is inappropriate for a
> network driver to have such a dependency.
> 
> Make the declaration of walk_memory_resource() and its powerpc
> implementation (ehea is powerpc-specific) unconditionally available.

Paul, can you take these two patches, or should I send them to akpm?
