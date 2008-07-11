Return-Path: <glikely@secretlab.ca>
Date: Fri, 11 Jul 2008 12:12:14 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] Convert i2c-mpc from a platform driver into a
	of_platform driver, V4
Message-ID: <20080711181214.GA15321@secretlab.ca>
References: <20080630230126.12482.87927.stgit@terra>
	<fa686aa40807091022q22f6be99j89f311780bd3d369@mail.gmail.com>
	<8EAD138A-6CE4-4AC7-BCBF-13B8E7C24CF1@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8EAD138A-6CE4-4AC7-BCBF-13B8E7C24CF1@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2008 at 12:36:58PM -0400, Timur Tabi wrote:
>
> On Jul 9, 2008, at 1:22 PM, Grant Likely wrote:
>
>> On Mon, Jun 30, 2008 at 5:01 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>> Convert i2c-mpc to an of_platform driver. Utilize the code in  
>>> drivers/of-i2c.c to make i2c modules dynamically loadable by the  
>>> device tree.
>>
>> Timur, can you please test this one on an 83xx platform?  It works on
>> 5200, but I want to make sure 83xx doesn't break before I pick it up.
>
> I'm on vacation this week, so I'll have to deal with it next week, after 
> I've handled higher-priority issues.

Kumar, is there anyone else who can test this out before the merge
window opens?

OTOH, it should be pretty safe.  It's been tested on 5200.  I could just
pick it up without 8xxx testing if you're okay with it.

g.
