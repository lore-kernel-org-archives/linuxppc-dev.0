Return-Path: <Renaud.Barbier@ge.com>
Received: from ext-ch1gw-1.online-age.net (ext-ch1gw-1.online-age.net
	[216.34.191.35]) by ozlabs.org (Postfix) with ESMTP id A21122BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Dec 2004 05:34:02 +1100 (EST)
Received: from int-ch1gw-3.online-age.net (int-ch1gw-3 [3.159.232.67])
	by ext-ch1gw-1.online-age.net (8.12.9/8.12.9/990426-RLH) with ESMTP id
	iB6IMEZl010872
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Dec 2004 13:22:15 -0500 (EST)
Received: from cinmlef04.e2k.ad.ge.com (localhost [127.0.0.1])
	by int-ch1gw-3.online-age.net (8.12.9/8.12.3/990426-RLH) with ESMTP id
	iB6IMDV8026424
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Dec 2004 13:22:13 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 6 Dec 2004 12:23:09 -0600
Message-ID: <45ABD2373C33C4459D42B40EC4F346F204912B38@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: 440GX MMU
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


can someone explain to me the purpose of the TS bit in the 440GX TLBs?

In the 440GX BSP, what is the point to map twice memory offset 0 (once =
with TS=3D0 and once with TS=3D1).
Is that for context switch?
