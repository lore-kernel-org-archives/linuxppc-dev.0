Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18565.16369.993585.334427@cargo.ozlabs.ibm.com>
Date: Tue, 22 Jul 2008 12:03:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [RFC v3 PATCH 6/4] Use LOAD_REG_IMMEDIATE macros
In-Reply-To: <4884E2E9.6050108@in.ibm.com>
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184055.GB25070@in.ibm.com>
	<1216325187.7740.353.camel@pasglop> <48802AE0.30105@in.ibm.com>
	<d8d07a180aaf59d25936ad03c7287f5a@bga.com>
	<4884E2E9.6050108@in.ibm.com>
Cc: naren@linux.vnet.ibm.com, Milton Miller <miltonm@bga.com>,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

@@ -714,7 +714,7 @@ _GLOBAL(enter_rtas)
         std	r6,PACASAVEDMSR(r13)
 
 	/* Setup our real return addr */	
-	LOAD_REG_ADDR(r4,.rtas_return_loc)
+	LOAD_REG_IMMEDIATE(r4,.rtas_return_loc)

If LOAD_REG_ADDR doesn't work, then how are all the TOC loads in
gcc-generated code going to work?

Paul.
