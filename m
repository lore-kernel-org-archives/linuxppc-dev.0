Message-ID: <3D0849F5.6080003@embeddededge.com>
Date: Thu, 13 Jun 2002 03:29:57 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: get_pteptr()
References: <20020613040345.GD4228@zax> <3D08276D.3080502@embeddededge.com> <20020613052745.GF4228@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Do you mean get_pteptr() or iopa()?

In iopa().  Just put an #ifdef in there for 4xx that does addr - KERNELBASE,
just like virt_to_bus/phys does for other processors (except 8xx).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
