Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18565.21851.162729.652176@cargo.ozlabs.ibm.com>
Date: Tue, 22 Jul 2008 13:34:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/16 v3] powerpc: Remove extraneous error reporting for
	hcall failures in lparcfg
In-Reply-To: <20080704125106.GB1310@linux.vnet.ibm.com>
References: <20080704124449.GA1310@linux.vnet.ibm.com>
	<20080704125106.GB1310@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> From: Nathan Fontenot <nfont@austin.ibm.com>
> 
> Remove the extraneous error reporting used when a hcall made from lparcfg fails.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
