Message-ID: <3C4F488D.1@embeddededge.com>
Date: Wed, 23 Jan 2002 18:34:37 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI2000 and failed MMU translations
References: <638AA0336D7ED411928700D0B7B0D75BB32418@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gessner, Matt wrote:

> Whooops, too soon.

I'm sure it's my fault, I'm sorry.

I started making some changes to support large page sizes and I think
it screwed up the BDI2000.  I'll have a patch in as quickly as possible
(yet tonight) and post it.  I won't be able to test it with the BDI2000
but it is basically backing out some changes I made.

I apologize.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
