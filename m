Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 1CC0CB6FD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 00:24:57 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 21772-05 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 15:24:47 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Changes to of_device ?
Date: Fri, 17 Jun 2011 15:23:11 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ADAB@saturn3.aculab.com>
In-Reply-To: <BANLkTi=uDe3WevxtnW8ns3ixMET7tbHzeQ@mail.gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> For finding structures, the following pattern tends to work well:
>=20
> git grep 'struct device_node {'

In general 'typedef.*\<type_name\>' will find types.
eg: grep -r -n --include '*.h' 'typedef.*\<type_name\>'
base_of_source_tree

Finding functions (in .c files) is easy if names start in
column 1 '^function_name\>' will work.
But I ended up with: '^[^=3D"]*[^ =3D][^=3D"]*function_name\>' to find
some where the type was on the same line.

If you get really desparate, the definitions of functions can
be found by grepping through the namelists of the .o files.

	David
