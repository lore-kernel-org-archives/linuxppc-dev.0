Return-Path: <Gabe.Johnson@radisys.com>
Received: from dcnotes.radisys.com (mail1.radisys.com [63.163.28.53])
	by ozlabs.org (Postfix) with ESMTP id 7BE5967C3F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 00:03:18 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: GPIO Control Driver
MIME-Version: 1.0
Message-ID: <OF017E2CDC.CE5677C5-ON862571D5.004A6EDF-862571D5.004BCA15@radisys.com>
From: Gabe.Johnson@radisys.com
Date: Fri, 25 Aug 2006 08:47:49 -0500
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am working on a PowerQuickIII processor that has a GPIO port, port C. 
Connect to this port are buffer enables for various devices on the 
product.  I am trying to write a driver to control certain GPIO lines. Any 
suggestions on the best way to implement this?  Currently I have created a 
module that creates character devices but I am now feeling it would have 
been better to create sysfs entries.  Looking at the structs from the 
Linux device model bus_type, device_driver, and device I am having 
troubles determining what needs to be declared?  What I think I would like 
to create in sysfs is:

/sys/module/<MODULE NAME>/rtm_enable
                                 /rtm_reset
                                 /clk1a_enable
                                 /clk1b_enable
                                 /clk2a_enable
                                 /clk2b_enable
