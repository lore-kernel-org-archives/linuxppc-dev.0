From: "Bob Doiron" <bob.doiron@amirix.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Possbile bug in hashtable.S : add_hash_page
Date: Mon, 28 Jun 2004 16:43:34 -0300
Message-ID: <NBBBIKIPCKOLLCLIHBIMGEPOEBAA.bob.doiron@amirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <6327D22A-C939-11D8-BD02-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I started with the vanilla 2.6.6 kernel, then I compared hashtable.S to the
one found here: http://ppc.bkbits.net:8080/linuxppc-2.5 and saw that it had
the same stack/interrupt handling within the add_hash_page function. The
processor is an mpc7457.

I guess I was hoping the ppc assembly guru's would check thier current ppc
hashtable.S to see if the code was the same, and if so, take a stab at
whether it looks reasonable given my problem explanation.

-Bob


-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Monday, June 28, 2004 4:29 PM
To: Bob Doiron
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Possbile bug in hashtable.S : add_hash_page



On Jun 28, 2004, at 2:40 PM, Bob Doiron wrote:

>
> Hi all. I'm working on an embedded ppc / linux project and I've run
> into
> what looks like a possible bug.

What kernel?  Where did you get it?  What processor?

> 	< do some magic >

can only be explained if we know more details.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
