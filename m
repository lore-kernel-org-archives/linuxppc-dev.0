Return-Path: <apw@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 586E667B6F
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 07:09:25 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6OL9Lwr018740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 17:09:22 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6OL9LQu277130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 17:09:21 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6OL9L3S017364
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 17:09:21 -0400
Date: Mon, 24 Jul 2006 17:09:21 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mpic discovery on JS20
Message-ID: <20060724210921.GB7139@kvasir.watson.ibm.com>
References: <20060720231601.GA24736@kvasir.watson.ibm.com>
	<1153503476.16159.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <1153503476.16159.13.camel@localhost.localdomain>
From: Amos Waterland <apw@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

***********************
Warning: Your file, js20-devtree.tar.gz, contains more than 32 files after decompression and cannot be scanned.
***********************


On Fri, Jul 21, 2006 at 01:37:56PM -0400, Benjamin Herrenschmidt wrote:
> On Thu, 2006-07-20 at 19:16 -0400, Amos Waterland wrote:
> > Current Linus and Paulus trees do this on JS20 blades with SLOF:
> 
> I need a tarball of /proc/device-tree on these. 

I booted 2.6.17-rc2 and tarred up /proc/device-tree.  Since the
compressed tarball is only 4KB I have attached it to this email.



--sm4nu43k4a2Rpi4c
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="js20-devtree.tar.gz"
Content-Transfer-Encoding: base64

H4sICB02xUQCA2pzMjAtZGV2dHJlZS50YXIA7Z3fiyRXFcdndxOmSHxYRMS3NMlLhG23flcQ
hAElEExMQlACQpLq7tqZYrur2qrqTTYPsi8igmBelPjjIYiIj3nMn+CfkDdFfFB8EfFhQTB2
z87MzlRX72zfOX1um/l8EXfZXViX6+ecuud+zzmj7E4+zPpNlWU3dzYkd64oig5/nKv94+HP
PTeMPT8I3GD+57zAd4OdXrSjoFndpFWvt1OVZfOoP3fe77f/cf8nGp06/yKdZJs6/zAMH3H+
Xuv8w8UPPZfzR0iN/3FezN67MT1Ii9E4U+U/bPEfxXEC/xpydn/+NyiA/wX/z6WjUZXVdX+Y
jce1Vf4Tz4V/JV2FAvg/5L/O38+k4Tfj3+f7H/6RLv/TcdrcKqtJv5xmRX+aD7X499v1nziM
fPjX0v0njn58Eh4uM/8Pfv52c3cqWwY8l/+oXf+LQh/+VTQ8qKa9d7NeWmW9omxu9AazpldP
0qrp3U0H839zL68XvwEpn3/+h+Vkmjb5YCz8CnAu/16y9P0fBvCvoVfKSVY0s8mNV9LpOIOH
y8x/OW3ysqjF34HXf/8N4yTm/dfW+Uu/A58f/9vnH0UB9V8VHZ05gZD4f8K/9Dvw+vXfJIi5
/6nIeeqnH0AB/J/hv0xH/UFaS30EnM9/vFT/nf9x+FeQFwcvhGAA/4v6z3RWb8IEbHD/m98A
uP9ZOf8NmIDPj/9R+/7netT/VLQ4c6Ig8f+E/w2YgNe//8Vx6MG/zv3vR+9AAfyf8L8BE7AJ
/9R/1HQFCuD/If/yJmAD/n2X/h+E9Pmf/9eeJ1sFWr/+E3k+9R+b5y9aBTLp/+L7T63+QxAk
/rf5F60CGbz/xx71H6X6z0/+CAXw3+JftBXExP8Tkv/J/8gW/1W2L3v/W3f+i0f9R0vUf+G/
zX+TT7KFA7B/q8p+MMuK4V1N/n03Dsj/Knr67y/9CQrgv8X/cFwOb4vAb8a/F+D/VdHbb10H
Avhfuv/3h+nwIOsvHoNt3P/9Rf8n/GvoHhDA/yr+x3lx8SBgkP99H/83AQDZ4j+3nP8DF/51
RPUP/lfzby3/M/+D/I8s8e9ugf8zxP9p8fzt+z/xf6kI/wfxv4N/+/5Pvv9U5Dz1YyCA/zb/
9v2f5H/yP7LFv33/J++/CNni377/k/yvIvyf8N/Bv33/J++/KsL/Cf9d93/r/k/2fyrpHhDA
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

--sm4nu43k4a2Rpi4c--
