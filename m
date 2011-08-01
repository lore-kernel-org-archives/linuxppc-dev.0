Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXJWTw33ehLAPq00WjsebBHtQd5B9nM5Y-Z5JtevzmVqA@mail.gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-11-git-send-email-a.heider@gmail.com>
	<CAMuHMdXJWTw33ehLAPq00WjsebBHtQd5B9nM5Y-Z5JtevzmVqA@mail.gmail.com>
Date: Mon, 1 Aug 2011 23:01:11 +0200
Message-ID: <CAHsu+b-1GQpSQ_1gi5Gz0KmnA10p5jspde=TPnnq7t3wUNvyJA@mail.gmail.com>
Subject: Re: [PATCH 10/15] ps3stor_lib: Add support for multiple regions
From: Andre Heider <a.heider@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	Hector Martin <hector@marcansoft.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 1, 2011 at 10:35 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Aug 1, 2011 at 22:03, Andre Heider <a.heider@gmail.com> wrote:
>> =A0 =A0 =A0 =A0priv->gendisk =3D gendisk;
>> +
>> + =A0 =A0 =A0 /* find first accessible region */
>> + =A0 =A0 =A0 for (region_idx =3D 0; region_idx < dev->num_regions; regi=
on_idx++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_bit(region_idx, &dev->accessible_=
regions)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->region_idx =3D regio=
n_idx;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>
> Why not
>
> priv->region_idx =3D __ffs(dev->accessible_regions);

Right, thanks. Will change that for v2
