Return-Path: <JHughes@Linx.co.uk>
Received: from stives3.stives.linx.gbr (gateway.linx.co.uk [194.131.232.48])
	by ozlabs.org (Postfix) with ESMTP id E61B767E7B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 20:33:27 +1000 (EST)
Message-ID: <DB1B6B12D0E2F0469EB35A9586066B6ECE75F6@stivesemail.stives.linx.gbr>
From: James Hughes <JHughes@Linx.co.uk>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 3 Aug 2005 11:19:44 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: EST MPC823 board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I am going to try to port/run Linux on to one of our custom boards here at
work, based on the EST MPC823 (ICM823A is the label on the EST board)
reference design (quite an old one). I cannot find a reference to this board
in the standard U-Boot list of board, does anyone have any
information/thoughts on the way to approach this. Is there a board that is
similar that I can base things on for example? I would add that our company
is new to Linux, having just chosen it as our new O/S for a new range of
devices - so please forgive any blatant mistakes. 

This project is a precursor to building new product based on the PXA270, but
the custom H/W for that is months and months away, so it seem prudent to get
some practice on the older boards using the MPC823 - the custom hardware
side is very similar and it gives us some practice at running Linux on
custom hardware - the application code we write should port to the newer
hardware when it is ready, and some of the device driver knowledge gained
will also be useful.

If anything thinks this is a bonkers idea, please let me now!!

Regards

James


The information contained in this e-mail message (and any attachment
transmitted herewith) is privileged and confidential and is intended for the
exclusive use of the addressee(s). If you are not an addressee, any
disclosure, reproduction, distribution or other dissemination or use of this
communication is strictly prohibited. If you have received this
communication in error, please contact us immediately so that we can correct
the error.
