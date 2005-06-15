Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 24C9967B54
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 04:00:13 +1000 (EST)
Date: Wed, 15 Jun 2005 11:00:11 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Garcia J?r?mie <GARCIAJ@3il.fr>
Message-ID: <20050615180011.GB21165@gate.ebshome.net>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B36@exnet.3il.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B36@exnet.3il.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: RE : Error while opennig device file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2005 at 07:47:56PM +0200, Garcia J?r?mie wrote:
> I'm sorry but this is a "copy to mail" error.  
> Here is the right code:
> 
> ret_val = system("mknod -m 777 /dev/test1 c 122 1");
> ret_val = system("mknod -m 777 /dev/test2 c 122 2");
> 
> file_desc1 = open("/dev/test1", O_RDWR);
> file_desc2 = open("/dev/test2", O_RDWR);
> 
> Sorry again but I would have liked that it was so easy...lol

OK, how does open routine for your device look like?
What error do you get on second open?

-- 
Eugene
