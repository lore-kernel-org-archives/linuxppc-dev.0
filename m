Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <484CECE2.9050605@grandegger.com>
References: <484CECE2.9050605@grandegger.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <519f1a6d9baeca8cfea9e8ad7a92c4d4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] booting-without-of: add more bindings for FSL UPM driver
Date: Mon, 9 Jun 2008 12:30:48 +0200
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +      - chip-delay : may specify a delay value in milliseconds.

Delay for what?  The binding should say.  "chip-delay" is a bit
too generic name as well, it could be more descriptive perhaps.

Shouldn't this be a property of the NAND device anyway, not the
NAND controller?


Segher
