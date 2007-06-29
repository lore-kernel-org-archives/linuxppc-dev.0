Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18052.40863.367296.693217@cargo.ozlabs.ibm.com>
Date: Fri, 29 Jun 2007 15:58:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: arnd@arndb.de
Subject: Re: [patch 2/9] autoselect optimal -mcpu= flag by platform
In-Reply-To: <20070616000618.314570319@arndb.de>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.314570319@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arnd@arndb.de writes:

> +config PPC_CPU_SELECTION
> +	bool "Advanced CPU selection"

Please provide some reasonable help for this option.  As it is at the
moment, I get asked whether I want "Advanced CPU selection" - whatever
that is - and as a user I have no clue whether I want it or not.  The
prompt is pretty uninformative.  Do I want to be able to select an
advanced CPU?  Well I suppose I do - who would want to select a
retarded CPU? - but that's presumably not what the question's about.

Paul.
