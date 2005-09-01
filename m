Return-Path: <dhlii@comcast.net>
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [204.127.202.55])
	by ozlabs.org (Postfix) with ESMTP id 0CEE268106
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Sep 2005 08:35:58 +1000 (EST)
Message-ID: <43177FF0.80006@comcast.net>
Date: Thu, 01 Sep 2005 18:25:52 -0400
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <A9DE2BAF233E444FA9C5E77A5825A01E865051@ydmail.sbell.com.cn>
In-Reply-To: <A9DE2BAF233E444FA9C5E77A5825A01E865051@ydmail.sbell.com.cn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Does the console have to be asigned to a serial or video driver ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

   
    I am working on a Linux Port to a very minimal Xilinx V4 FPGA card. 
At this point it would be extremely useful for me to assign the console 
to a fairly trivial char device that is little more than a 
bi-directional parallel port.

    Is that possible or do I have to impliment dummy code for all the 
required interfaces for a serial device ?
