Return-Path: <dan@embeddededge.com>
In-Reply-To: <20050408210458.GA16672@iram.es>
References: <20050408184442.GA13709@iram.es>
	<8497276598d775128a73efb06803a9ba@freescale.com>
	<20050408210458.GA16672@iram.es>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <091e271750ba6ff4b07e0a9cb9f68dae@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Apr 2005 17:31:43 -0400
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 8, 2005, at 5:04 PM, Gabriel Paubert wrote:

> ...... Loads are weekly
                               ^^^^^^
> ordered in general wrt each other and lwarx is no exception
> AFAIR.

Maybe that's my performance problem :-)


	-- Dan
