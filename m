Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Running external clock at 1/2 
Date: Thu, 31 Jan 2002 20:23:04 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F096A49@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I would like to the run the CLKOUT at half the frequency of the memory bus clock on an 855T processor. I do this by setting EBDF to 01 as the manual says. But it looks like the memory bus is also set to half here. Is this correct? Is there no way I can get the CLKOUT set to 1/2 of VCCOUT without also setting the bus clock to half? Am I missing something here?

Thanks in advance.

Navin Boppuri

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
