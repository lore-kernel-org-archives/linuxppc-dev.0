Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B211C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 22:04:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55AE20880
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 22:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55AE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dPbQ5MYNzDqJk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 08:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ucw.cz
 (client-ip=195.113.26.193; helo=atrey.karlin.mff.cuni.cz;
 envelope-from=pavel@ucw.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ucw.cz
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dPWl1NKNzDqHd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 08:01:23 +1000 (AEST)
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
 id 41158806A6; Mon,  8 Apr 2019 23:55:24 +0200 (CEST)
Date: Mon, 8 Apr 2019 23:55:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v10 02/18] counter: Documentation: Add Generic Counter
 sysfs documentation
Message-ID: <20190408215531.GB27592@amd>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <bd8362f23b99af938c7bced2104eca29888253b3.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <bd8362f23b99af938c7bced2104eca29888253b3.1554184734.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
 daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, david@lechnology.com,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, tglx@linutronix.de,
 fabrice.gasnier@st.com, esben@haabendal.dk, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, knaack.h@gmx.de,
 akpm@linux-foundation.org, shawnguo@kernel.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-02 15:30:37, William Breathitt Gray wrote:
> This patch adds standard documentation for the userspace sysfs
> attributes of the Generic Counter interface.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 230 ++++++++++++++++++++
>  MAINTAINERS                                 |   1 +
>  2 files changed, 231 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> new file mode 100644
> index 000000000000..566bd99fe0a5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -0,0 +1,230 @@
> +What:		/sys/bus/counter/devices/counterX/countY/count
> +KernelVersion:	5.2
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count data of Count Y represented as a string.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/ceiling
> +KernelVersion:	5.2
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count value ceiling for Count Y. This is the upper limit for the
> +		respective counter.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/floor
> +KernelVersion:	5.2
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count value floor for Count Y. This is the lower limit for the
> +		respective counter.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/count_mode
> +KernelVersion:	5.2
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count mode for channel Y. The ceiling and floor values for
> +		Count Y are used by the count mode where required. The following
> +		count modes are available:
> +
> +		normal:
> +			Counting is continuous in either direction.
> +
> +		range limit:
> +			An upper or lower limit is set, mimicking limit switches
> +			in the mechanical counterpart. The upper limit is set to
> +			the Count Y ceiling value, while the lower limit is set
> +			to the Count Y floor value. The counter freezes at
> +			count =3D ceiling when counting up, and at count =3D floor
> +			when counting down. At either of these limits, the
> +			counting is resumed only when the count direction is
> +			reversed.
> +
> +		non-recycle:
> +			The counter is disabled whenever a counter overflow or
> +			underflow takes place. The counter is re-enabled when a
> +			new count value is loaded to the counter via a preset
> +			operation or direct write.
> +
> +		modulo-n:
> +			A count value boundary is set between the Count Y floor
> +			value and the Count Y ceiling value. The counter is
> +			reset to the Count Y floor value at count =3D ceiling when
> +			counting up, while the counter is set to the Count Y
> +			ceiling value at count =3D floor when counting down; the
> +			counter does not freeze at the boundary points, but
> +			counts continuously throughout.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
> +What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
> +What:		/sys/bus/counter/devices/counterX/countY/function_available
> +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> +KernelVersion:	5.2
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Count Y
> +		configuration are listed in this file. Values are delimited by
> +		newline characters.

Elsewhere in sysfs we do space-separated:

pavel@amd:~$ cat /sys/power/state
freeze mem disk

And we use [] to mark current selection:

pavel@amd:~$ cat /sys/class/leds/tpacpi\:\:thinkvantage/trigger
[none] bluetooth-power rfkill-any rfkill-none kbd-scrolllock
kbd-numlock kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock
kbd-ctrllock kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock
kbd-ctrlrlock AC-online BAT0-charging-or-full BAT0-charging BAT0-full
BAT0-charging-blink-full-solid rfkill0 phy0rx phy0tx phy0assoc
phy0radio phy0tpt mmc0 timer heartbeat audio-mute audio-micmute
rfkill1

Note this only works if you have less than PAGE_SIZE of entries... and
will never have more.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrw1MACgkQMOfwapXb+vIrJACdGzny2kYErlj2vHsj5g0+nisf
vFUAn2r0eo4ejc8ifXJmGFrOjikVszOA
=36BY
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
