Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17062.30520.173041.102963@cargo.ozlabs.ibm.com>
Date: Wed, 8 Jun 2005 14:42:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Baxter, Robert" <rbaxter@CURTISSWRIGHT.com>
In-Reply-To: <2A059D6F07F8054294EFC0BD7808FC6D3BE3E1@sdgexch01>
References: <2A059D6F07F8054294EFC0BD7808FC6D3BE3E1@sdgexch01>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: Getting ownership for various boards/platforms configs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Baxter, Robert writes:

> > gemini
> 
> I'll take this one.

Great!  There are some changes to head.S that I have been wanting to
make for a while: specifically I want to remove the special case for
starting the second processor on gemini and the call to
gemini_prom_init.

Does current 2.6 work on gemini?

Paul.
