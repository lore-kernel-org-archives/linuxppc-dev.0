Return-Path: <martyn.welch@gefanuc.com>
Message-ID: <4933D6F3.6050807@gefanuc.com>
Date: Mon, 01 Dec 2008 12:22:11 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
Subject: Re: MPC8313 and Marvell PHY 88e1112
References: <1227873994.3812.21.camel@parana>
In-Reply-To: <1227873994.3812.21.camel@parana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Carlos Roberto Moratelli wrote:
> Hi,
> 

Hi Carlos,

> I am working in a custom board based on a mpc8313erdb and my Kernel
> version is 2.6.24. This board has a Marvell PHY 88E1112 on TSEC2
> processor port. 
> 
> The problem is that the PHY is detected and configured, but no data can
> be send or received. I am sure that dtb is fine. In another custom board
> I have a 88e3015 on TSEC2 and it is working fine.
> 
> Did someone work with this PHY? Does Compiling gianfar and Marvell
> support on Kernel is enough? 

We have a board using a 8641d and Marvel 88E1111 PHY. I had problems getting the PHY to work correctly when using the Marvell PHY driver, however we were using the PHY as a standard PHY and found that the generic PHY driver worked just fine. Have you tried it without enabling the Marvell PHY driver so it uses the generic one?

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
