Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 6098F67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 18:06:25 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: Dan Malek <dan@embeddededge.com>
Date: Fri, 15 Apr 2005 10:38:25 +0200
References: <200504140926.01775.Schramel.Linux@go.bartec.de>
	<200504142024.41126.rscop@matrix.com.br>
	<ca0dbea676037b37464b3318b4271a30@embeddededge.com>
In-Reply-To: <ca0dbea676037b37464b3318b4271a30@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504151038.25073.Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: CPM uart
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

thanks for helping me.
Now it works with my configuration. 
I added SCC_NUM_BASE as it is without console. And now it works.
#ifdef SCC_CONSOLE
				switch (state->smc_scc_num - SCC_NUM_BASE) {  /*SCC_NUM_BASE added*/
				case 0:
					page = CPM_CR_SCC1_PAGE;
					sblock = CPM_CR_SCC1_SBLOCK;
					break;
				case 1:
					page = CPM_CR_SCC2_PAGE;
					sblock = CPM_CR_SCC2_SBLOCK;
					break;
				case 2:
					page = CPM_CR_SCC3_PAGE;
					sblock = CPM_CR_SCC3_SBLOCK;
					break;
				}
#else
.
.
.

Seems the use of SMC in conjunction with console on SCC was not planed in this version.
Furthermore i will test it and post if it fails. 

Best regards
Marco


---------
Marco Schramel
