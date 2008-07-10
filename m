Return-Path: <timur@freescale.com>
Message-Id: <8EAD138A-6CE4-4AC7-BCBF-13B8E7C24CF1@freescale.com>
From: Timur Tabi <timur@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40807091022q22f6be99j89f311780bd3d369@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 1/2] Convert i2c-mpc from a platform driver into a
	of_platform driver, V4
Date: Thu, 10 Jul 2008 12:36:58 -0400
References: <20080630230126.12482.87927.stgit@terra>
	<fa686aa40807091022q22f6be99j89f311780bd3d369@mail.gmail.com>
Cc: Linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 9, 2008, at 1:22 PM, Grant Likely wrote:

> On Mon, Jun 30, 2008 at 5:01 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Convert i2c-mpc to an of_platform driver. Utilize the code in  
>> drivers/of-i2c.c to make i2c modules dynamically loadable by the  
>> device tree.
>
> Timur, can you please test this one on an 83xx platform?  It works on
> 5200, but I want to make sure 83xx doesn't break before I pick it up.

I'm on vacation this week, so I'll have to deal with it next week,  
after I've handled higher-priority issues.
