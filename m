Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id CA26067CD2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 03:21:36 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so174016ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Dec 2006 08:21:34 -0800 (PST)
Message-ID: <528646bc0612060821u6fbb0de2o26d04ab67d705d75@mail.gmail.com>
Date: Wed, 6 Dec 2006 09:21:34 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: How to use the device tree for lite5200
In-Reply-To: <528646bc0612060820w5be26647h2c14730856cc6ad6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4576E8CC.6050508@grandegger.com>
	<528646bc0612060820w5be26647h2c14730856cc6ad6@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/6/06, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 12/6/06, Wolfgang Grandegger <wg@grandegger.com> wrote:
> >    $ dtc -b0 lite5200.dts
> >    DTC: dts->dts  on file "lite5200.dts"
> >    ERROR: Missing /chosen node
> >    Input tree has errors
>
> Add the -f flag to dtc to ignore the missing /chosen node error
>
> Use the "-O dtb" flag to output a fdt blob

Oh, and like Kumar said, you need the -V 0x10 flag to generate the
correct blob version.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
