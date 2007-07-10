Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18068.4589.614583.210312@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jul 2007 09:10:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] Consolidate mm_context_t definition in mmu.h
In-Reply-To: <1184089950.32199.24.camel@weaponx.rchland.ibm.com>
References: <1184089950.32199.24.camel@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> All of the platforms except PPC64 share a common mm_context_t definition.
> Defining it in mmu.h avoids duplicating it in the platform specific mmu
> header files.  We further consolidate it by having the PPC32 definition
> share the mm_context_id_t type for the id member.

Unfortunately the string of ifdefs in your consolidated version makes
my eyes water.  I'm not sure it isn't better the way it is.

Paul.
