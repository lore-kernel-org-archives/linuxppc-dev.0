Date: Wed, 22 Aug 2001 13:27:20 -0400
From: thewalthamgroup@netscape.net (Mark Phillips)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Text address for 8xx
Message-ID: <158A3A7A.7EA3EBDC.C7F6CBA8@netscape.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all.

It seems that with newer kernels, the text address in arch/ppc/8xx/mbxboot/Makefile is too low for the 8xx processors.  I had a problem with linux-2.4.4-2001-07-23 (upgrading from the pre6-2001-04-24) in that the kernel is now larger than 0x180000 (I get greedy when I see all those options!)

Is there a good reason not to make this 400000 for all processors?

Sincerely,
Mark Phillips


__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
