Return-Path: <galak@kernel.crashing.org>
Message-Id: <0EE7A51D-FCB1-4A52-B5F6-4F9D7588A361@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Bizhan Gholikhamseh (bgholikh) <bgholikh@cisco.com>
In-Reply-To: <F795765B112E7344AF36AA9112796415069F13E6@xmb-sjc-212.amer.cisco.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Graphic Card on Freescale  MPC837x-rdb
Date: Tue, 24 Jun 2008 12:32:59 -0500
References: <F795765B112E7344AF36AA9112796415069F13E6@xmb-sjc-212.amer.cisco.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2008, at 12:17 PM, Bizhan Gholikhamseh (bgholikh) wrote:

> HI all,
> Has anyone tried using a Graphic card on Freescale MPC837x-rdb  
> board? If so I appreciate any hints and information that I can use.

Nope, but you'll most likely need some form of x86 emulation for the  
video bios init.

- k
