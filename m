Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18565.42340.817405.289271@cargo.ozlabs.ibm.com>
Date: Tue, 22 Jul 2008 19:16:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Chandru <chandru@in.ibm.com>
Subject: Re: [PATCH 1/4][V2] powerpc : add support for linux,
	usable-memory properties for drconf memory
In-Reply-To: <200807221431.49268.chandru@in.ibm.com>
References: <200807080014.24910.chandru@in.ibm.com>
	<200807111639.22032.chandru@in.ibm.com>
	<200807111919.36401.chandru@in.ibm.com>
	<200807221431.49268.chandru@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chandru writes:

> Scan for linux,usable-memory properties in case of dynamic reconfiguration 
> memory . Support for kexec/kdump.
> 
> Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>

Could we *please* have a more comprehensive patch description that
that?  Something which will help people coming along in two (or five
or ten) years time to understand what problem exists in the code, how
this patch solves it, and why this approach was chosen over any
alternative approaches?

Thanks,
Paul.
