Subject: Re: multiple separate pci bridges ...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040119141623.GA21373@iliana>
References: <20040118144412.GA6897@iliana>
	 <1074443601.9704.164.camel@thor.asgaard.local>
	 <20040119134831.GA21093@iliana>
	 <1074520948.9700.248.camel@thor.asgaard.local>
	 <20040119141623.GA21373@iliana>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074522687.16178.258.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 15:31:28 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-01-19 at 15:16, Sven Luther wrote:
> BTW, is it time to move this thread to the dri-devel list or something ?

It wouldn't be really on topic there either, so maybe just take it off
list?


> With radeon it does work. I believe this is because the ati module
> lacks knowledge about the 5964 to choose the submodule ?

Right, I forgot to merge that.


> That said, DRI doesn't work, because it lacks the 9200SE recognition
> code, i suppose. Should it be ok to apply the same patch that was posted
> on the debian-x list to your dri-trunk package also ?

RV280 chips should be treated correctly AFAICT. How does it fail?


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
