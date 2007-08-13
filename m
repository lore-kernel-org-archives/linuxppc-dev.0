Return-Path: <domen.puncer@telargo.com>
Date: Mon, 13 Aug 2007 11:31:07 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: basic and stupid question on wait_event and wake_up
Message-ID: <20070813093107.GG13994@moe.telargo.com>
References: <20070813084736.GF13994@moe.telargo.com>
	<BAY138-F307C7D793CEC734113D325B2DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY138-F307C7D793CEC734113D325B2DC0@phx.gbl>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 13/08/07 09:22 +0000, Ming Liu wrote:
> Dear Momen,
> OK. I see now. So you mean condition is only to judge whether a sleeping 
> process could be waken up or not when wake_up() is executed in other 
> processes or interrupt handlers. What really wakes the process up is still 
> the function of wake_up, right? We just execute wake_up() and then check if 
> condition is true. If yes, the process will leave its sleeping and wake up; 
> if not, it keep sleeping. Am I right?

Right.


	Domen
